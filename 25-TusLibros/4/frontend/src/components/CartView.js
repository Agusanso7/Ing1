function CartView(props) {
  const { router, username, cartID } = props;
  const classes = useStyles();

  const [cartSize, setCartSize] = React.useState(0)

  const { session, loading, error } = useRefreshSession(username, cartID, cartSize);

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

  let total = session.cart.map(book => session.catalog[book]).reduce((x,y) => x + y, 0);

  return (
    <div>
        <Typography variant="h4" component="h4" gutterBottom>
            Cart

          <span style={{float: "right"}}>Total: ${total} </span>
        </Typography>

      <List component="nav" className={classes.rootList} aria-label="catalog">
        {
          Object.entries(session.catalog)
            .filter(([book, _]) => session.cart.includes(book)).map(([book, price]) => {

            let bookCount = session.cart.filter(b => b === book).length;
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
                      {`${book} - $${price}`}
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
                    onClick={() => handleAddToCart(cartID, book, 1).then(() => setCartSize(session.cart.length+1))}>

                    <Icon>add_shopping_cart</Icon>
                  </IconButton>

                  <IconButton edge="end" aria-label="comments"
                    disabled={bookCount == 0}
                    onClick={() => handleRemoveFromCart(cartID, book).then(() => setCartSize(session.cart.length-1))}>
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
        onClick={() => handleSend(values.username, values.password)}>
        >
          Checkout
          </Button>
    </div>
  )
}
