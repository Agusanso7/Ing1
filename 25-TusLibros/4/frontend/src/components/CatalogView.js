function CatalogView(props) {
  const { router, username, cartID } = props;
  const classes = useStyles();

  const [cartSize, setCartSize] = React.useState(0)

  const { session, loading, error } = useRefreshSession(username, cartID, cartSize);

  if (loading) { return <div>Loading...</div> }
  if (error) return <div>{error}</div>

  return (
    <div>
      <Typography variant="h4" component="h4" gutterBottom>
          Catalogo
      </Typography>

      <List component="nav" className={classes.rootList} aria-label="catalog">
        {
          session.catalog.map(book => {
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

    </div>
  )
}
