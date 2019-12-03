function BookListItem(props) {
  const { router, cartID, book, quantity, handleAdd, handleRemove } = props;
  const classes = useStyles();

  let bookCountString = '';

  if(quantity > 0) {
    bookCountString = ` - (${quantity})`;
  }

  return (
    <ListItem
      key={book}
      dense
      button
      onClick={() => {router.navigate('/book', { selectedBook: book })}}
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
          onClick={handleAdd}>

          <Icon>add_shopping_cart</Icon>
        </IconButton>

        <IconButton edge="end" aria-label="comments"
          disabled={quantity === 0}
          onClick={handleRemove}>
          <Icon>remove_shopping_cart</Icon>
        </IconButton>
      </ListItemSecondaryAction>
    </ListItem>
  )
}
