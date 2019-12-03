const useFetchPurchrases = (username, password) => {
  const [purchrases, setPurchrases] = React.useState([])
  const [loading, setLoading] = React.useState(true)
  const [error, setError] = React.useState(null)

  React.useEffect(() => {
    getLocalAsJson(`listPurchrases?username=${username}&password=${password}`)
      .then(function (response) {
        return response.json()
      })
      .then(function (purchrases) {
        if(purchrases) {
          setPurchrases(purchrases)
        }

        setLoading(false)
      })
      .catch(err => {
        setError(err)
        setLoading(false)
      })
  }, [username])

  return { purchrases, loading, error }
}

function PurchrasesView(props) {
  const { router, username, password, catalog } = props;
  const classes = useStyles();

  let { purchrases, loading, error } = useFetchPurchrases(username, password)

  const bookByISBN = (isbn) => catalog.find(book => book.isbn === isbn)

  if (loading) { return <div>Loading...</div> }
  if (error) return <div>{error}</div>

  return (
    <div>
      <Typography variant="h4" component="h4" gutterBottom>
          Purchrases
      </Typography>

        { purchrases.length == 0 &&
            <Typography variant="h5"  gutterBottom>
                You should buy something... ;)
            </Typography>
        }

        { purchrases.length > 0 &&
            <List component="nav" className={classes.rootList} aria-label="catalog">
              {
                purchrases.map(item => (
                  <ListItem key={item.name} dense >
                    <ListItemText
                      primary={`${bookByISBN(item.name).name} - $${item.total}`}
                      secondary={`ISBN: ${item.name} - Quantity: ${item.quantity}`}
                    />
                  </ListItem>
                ))
              }
            </List>
        }

    </div>
  )
}
