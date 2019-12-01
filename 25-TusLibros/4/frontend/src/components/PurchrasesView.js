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
  const { router, username, password } = props;
  const classes = useStyles();

  let { purchrases, loading, error } = useFetchPurchrases(username, password)

  if (loading) { return <div>Loading...</div> }
  if (error) return <div>{error}</div>

  return (
    <div>
      <Typography variant="h4" component="h4" gutterBottom>
          Purchrases
      </Typography>

      <List component="nav" className={classes.rootList} aria-label="catalog">
        {
          Object.entries(purchrases).map(([book, total]) => {
            return (
              <ListItem
                key={book}
                dense
                >
                <ListItemText primary={`${book} - $${total}`} />
              </ListItem>
            )
          })
        }
      </List>

    </div>
  )
}
