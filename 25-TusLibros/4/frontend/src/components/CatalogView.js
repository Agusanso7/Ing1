const useFetchCatalog = (username) => {
  const [catalog, setCatalog] = React.useState({})
  const [loading, setLoading] = React.useState(false)
  const [error, setError] = React.useState(null)

  React.useEffect(() => {
    setLoading(true)
    setError(null)

    getLocalAsJson(`catalog`)
      .then(function (response) {
        return response.json()
      })
      .then(function (catalog) {
        setLoading(false)
        if (catalog) {
          setCatalog(catalog)
        } else {
          setCatalog({})
        }
      })
      .catch(err => {
        setError(err)
        setLoading(false)
      })
  }, [username])

  return { catalog, loading, error }
}

function CatalogView(props) {
  const { router, username, cartID } = props;
  const classes = useStyles();

  const { catalog, loading, error } = useFetchCatalog(username);

  if (loading) return <div>Loading...</div>
  if (error) return <div>{error}</div>

  return (
    <div>
      <Typography variant="h4" component="h4" gutterBottom>
          Catalogo
      </Typography>

      <List component="nav" className={classes.rootList} aria-label="catalog">
        {
          Object.entries(catalog).map(([book, price]) => {
            return (
              <ListItem
                key={book}
                dense
                >
                <ListItemText primary={`${book} - $${price}`} />
                <ListItemSecondaryAction>
                  <IconButton edge="end" aria-label="comments"
                    onClick={() => handleAddToCart(cartID, book, 1)}>
                      +
                  </IconButton>
                  <IconButton edge="end" aria-label="comments"
                    onClick={() => handleRemoveFromCart(cartID, book)}>
                      -
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
