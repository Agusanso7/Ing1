function CartView(props) {
  const { router, username, password, cartID, catalog, cartContent, refreshCart } = props;
  const classes = useStyles();

  const [checkoutModalOpen, setCheckoutModalOpen] = React.useState(false);
  const [ticket, setTicket] = React.useState({});

  const bookByISBN = (isbn) => catalog.find(book => book.isbn === isbn)

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

  if(cartContent.length == 0) {
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

  let total = cartContent
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
          catalog.filter(book => cartContent.includes(book.isbn)).map(book => {
            let bookCount = cartContent.filter(isbn => isbn === book.isbn).length;

            return (
              <BookListItem
                router={router}
                key={book.isbn}
                cartID={cartID}
                book={book}
                quantity={bookCount}
                handleAdd={() => addToCart(cartID, book.isbn, 1).then(refreshCart)}
                handleRemove={() => removeFromCart(cartID, book.isbn).then(refreshCart)}
              />
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
