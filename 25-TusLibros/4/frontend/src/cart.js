const addToCart = (id, book, qty) => {
  return getLocalAsJson(`addToCart?cart_id=${id}&isbn=${book}&quantity=${qty}`)
    .catch(function (error) {
      console.log('Looks like there was a problem adding to cart: \n', error);
    });
};

const removeFromCart = (id, book) => {
  return getLocalAsJson(`removeFromCart?cart_id=${id}&isbn=${book}`)
    .catch(function (error) {
      console.log('Looks like there was a problem removing from cart: \n', error);
    });
};

const createCart = (username, password) => {
  return getLocalAsJson(`createCart?username=${username}&password=${password}`)
};

const listCart = (id) => {
  return getLocalAsJson(`listCart?id=${id}`)
};

const checkoutCart = (id, username, password) => {
  return getLocalAsJson(`checkout?cart_id=${id}&username=${username}&password=${password}`)
};

