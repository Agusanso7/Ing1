const useFetchCart = (id) => {
  const [cart, setCart] = React.useState([])
  const [loading, setLoading] = React.useState(false)
  const [error, setError] = React.useState(null)

  React.useEffect(() => {
    setLoading(true)
    setError(null)

    getLocalAsJson(`listCart?id=${id}`)
      .then(function (response) {
        return response.json()
      })
      .then(function (cart) {
        setLoading(false)
        if (cart) {
          setCart(cart)
        } else {
          setCart([])
        }
      })
      .catch(err => {
        setError(err)
        setLoading(false)
      })
  }, [id])

  return { cart, loading, error }
}

const handleAddToCart = (id, book, qty) => {
  getLocalAsJson(`addToCart?cart_id=${id}&book_id=${book}&quantity=${qty}`)
    .catch(function (error) {
      console.log('Looks like there was a problem adding to cart: \n', error);
    });
};

const handleRemoveFromCart = (id, book) => {
  getLocalAsJson(`removeFromCart?cart_id=${id}&book_id=${book}`)
    .catch(function (error) {
      console.log('Looks like there was a problem removing from cart: \n', error);
    });
};

