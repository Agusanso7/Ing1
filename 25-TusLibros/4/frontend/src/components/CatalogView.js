function CatalogView(props) {
  const { router, cartID, catalog, cartContent, refreshCart } = props;
  const classes = useStyles();

  return (
    <div>
      <Typography variant="h4" component="h4" gutterBottom>
          Catalog
      </Typography>

      <List component="nav" className={classes.rootList} aria-label="catalog">
        {
          catalog.map(book => {
            let bookCount = cartContent.filter(isbn => isbn === book.isbn).length;

            return (
              <BookListItem
                key={book.isbn}
                router={router}
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
    </div>
  )
}
