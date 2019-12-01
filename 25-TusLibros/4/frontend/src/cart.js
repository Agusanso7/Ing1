const useRefreshSession = (username, cartID, cartSize) => {
  const [session, setSession] = React.useState({})
  const [loading, setLoading] = React.useState(true)
  const [error, setError] = React.useState(null)

  React.useEffect(() => {
    let session = {
      catalog: {},
      cart: []
    }

    getLocalAsJson(`catalog`)
      .then(function (response) {
        return response.json()
      })
      .then(function (catalog) {
        session.catalog = catalog
      }).then(function() {
        return getLocalAsJson(`listCart?id=${cartID}`)
      }).then(function (response) {
        return response.json()
      }).then(function (cart) {
        session.cart = cart

        if(cart) {
          setSession(session)
        }

        setLoading(false)
      })
      .catch(err => {
        setError(err)
        setLoading(false)
      })
  }, [username, cartID, cartSize])

  return { session, loading, error }
}


const handleAddToCart = (id, book, qty) => {
  return getLocalAsJson(`addToCart?cart_id=${id}&book_id=${book}&quantity=${qty}`)
    .catch(function (error) {
      console.log('Looks like there was a problem adding to cart: \n', error);
    });
};

const handleRemoveFromCart = (id, book) => {
  return getLocalAsJson(`removeFromCart?cart_id=${id}&book_id=${book}`)
    .catch(function (error) {
      console.log('Looks like there was a problem removing from cart: \n', error);
    });
};

const createCart = (username, password) => {
  return getLocalAsJson(`createCart?username=${username}&password=${password}`)
};

