function BookView(props) {
  const classes = useStyles();
  const { cartID, book, refreshCart, cartContent } = props;

  let quantity = cartContent.filter(isbn => isbn === book.isbn).length

  return (
    <div>
      <Paper className={classes.root} style={{padding: theme.spacing(3, 2)}}>
        <Typography variant="h4" component="h4" gutterBottom>
            {book.name}
        </Typography>

        <Typography variant="subtitle1" component="subtitle1" gutterBottom>
            By: {book.author} - ISBN: {book.isbn}
        </Typography>

        <Typography variant="p" component="p" style={{ marginTop: '10px' }} gutterBottom>
            {book.description}
        </Typography>
      </Paper>

      <Paper className={classes.root} style={{marginTop: '10px', padding: theme.spacing(3, 2)}}>
        <strong>Price ${book.price}</strong>

        <IconButton edge="end" aria-label="comments"
          onClick={() => addToCart(cartID, book.isbn, 1).then(refreshCart)}>

          <Icon>add_shopping_cart</Icon>
        </IconButton>

        <IconButton edge="end" aria-label="comments"
          disabled={quantity === 0}
          onClick={() => removeFromCart(cartID, book.isbn, 1).then(refreshCart)}>
          <Icon>remove_shopping_cart</Icon>
        </IconButton>

        <Typography variant="p" component="p" style={{ marginTop: '10px' }} color="textSecondary" gutterBottom>
            Quantity: {quantity}
        </Typography>
      </Paper>
    </div>
  )
}

