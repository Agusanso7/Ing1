function CartView(props) {
  const { router, username, password, cartID } = props;
  const classes = useStyles();

  const [cartSize, setCartSize] = React.useState(0)

  const { session, loading, error } = useRefreshSession(username, cartID, cartSize);

  const [checkoutModalOpen, setCheckoutModalOpen] = React.useState(false);
  const [ticket, setTicket] = React.useState({});

  const bookByISBN = (isbn) => session.catalog.find(book => book.isbn === isbn)

  const handleCheckout = () => {
    checkoutCart(cartID, username, password)
      .then(function (response) {
        return response.json()
      }).then(function (ticket) {
        setTicket(ticket)

        setCheckoutModalOpen(true);
      }).catch(function (error) {
        console.log('Looks like there was a problem removing from cart: \n', error);
      });
    setCheckoutModalOpen(true);
  };

  const handleClose = () => {
    createCart(username,password)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        setCheckoutModalOpen(false);
        router.navigate("/catalog", { cartID: json.cart_id })
      })
  };

  if (loading) { return <div>Loading...</div> }
  if (error) { return <div>{error}</div> }


  if(session.cart.length == 0) {
    return (
      <div>
        <Typography variant="h4" component="h4" gutterBottom>
            Cart
        </Typography>

        <Typography variant="h5"  gutterBottom>
            Oops, Your cart is empty... why don't you buy something? :)
        </Typography>
      </div>
    )
  }

  let total = session.cart
    .map(isbn => bookByISBN(isbn).price)
    .reduce((x,y) => x + y, 0);

  return (
    <div>
        <Typography variant="h4" component="h4" gutterBottom>
            Cart

          <span style={{float: "right"}}>Total: ${total} </span>
        </Typography>

      <List component="nav" className={classes.rootList} aria-label="catalog">
        {
          session.catalog.filter(book => session.cart.includes(book.isbn)).map(book => {

            let bookCount = session.cart.filter(isbn => isbn === book.isbn).length;
            let bookCountString = '';

            if(bookCount > 0) {
              bookCountString = ` - (${bookCount})`;
            }

            return (
              <ListItem
                key={book}
                dense
                >
                <ListItemText primary={<React.Fragment>
                    <Typography
                      component="span"
                      variant="body2"
                      className={classes.inline}
                      color="textPrimary"
                    >
                      {`${book.name} - $${book.price}`}
                  </Typography>
                  <Typography
                      component="span"
                      variant="body2"
                      className={classes.inline}
                      color="textSecondary"
                    >
                      {bookCountString}
                  </Typography>
                </React.Fragment>
                } />

                <ListItemSecondaryAction>
                  <IconButton edge="end" aria-label="comments"
                    onClick={() => handleAddToCart(cartID, book.isbn, 1).then(() => setCartSize(session.cart.length+1))}>

                    <Icon>add_shopping_cart</Icon>
                  </IconButton>

                  <IconButton edge="end" aria-label="comments"
                    disabled={bookCount == 0}
                    onClick={() => handleRemoveFromCart(cartID, book.isbn).then(() => setCartSize(session.cart.length-1))}>
                    <Icon>remove_shopping_cart</Icon>
                  </IconButton>
                </ListItemSecondaryAction>
              </ListItem>
            )
          })
        }
      </List>

      <Button
      variant="contained"
        className={classes.Button}
        style={{float: 'right', marginTop: "15px"}}
        color="primary"
        onClick={() => handleCheckout()}>
        >
          Checkout
          </Button>

     <Modal
        aria-labelledby="transition-modal-title"
        aria-describedby="transition-modal-description"
        className={classes.modal}
        open={checkoutModalOpen}
        onClose={handleClose}
        closeAfterTransition
        BackdropComponent={Backdrop}
        BackdropProps={{
          timeout: 500,
        }}
      >
        <Fade in={checkoutModalOpen}>
          <div className={classes.paper}>
            <typography component="h1" id="transition-modal-title"><strong>Ticket</strong></typography>

            <Paper className={classes.root} id="transition-modal-description">
              <List component="nav" aria-label="main mailbox folders">
                {
                  (ticket.items || []).map(item => {
                    return (
                      <ListItem key={item.name}>
                        <ListItemText primary={`${bookByISBN(item.name).name} X ${item.quantity} - $${item.total}`} secondary={`ISBN: ${item.name}`} />
                      </ListItem>
                    )
                  })
                }
              </List>
            </Paper>

            <typography component="h3" id="transition-modal-title">Total: ${ticket.total}</typography>
          </div>
        </Fade>
      </Modal>
    </div>
  )
}
