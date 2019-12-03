class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      path: "/",
      username: '',
      password: '',
      cartID: null,
      catalog: [],
      cartContent: [],
      selectedBook: {},
    };
  }

  refreshCart = () => {
    if(!this.state.cartID) {
      this.setState({ cartContent: [] })
      return
    }

    listCart(this.state.cartID)
      .then(response => {
        return response.json()
      }).then(cartContent => {
        this.setState({ cartContent: cartContent })
      })
  }

  componentDidMount() {
    getLocalAsJson(`catalog`)
      .then(response => {
        return response.json()
      }).then(catalog => {
        this.setState({ catalog: catalog })
      })
  }

  componentDidUpdate(prevProps, prevState) {
    if(prevState.cartID !== this.state.cartID) {
      this.refreshCart()
    }
  }

  render() {
    let title = "Tus Libros"
    let content = "Where am I?"
    const router = {
      current: () => this.state.path,
      navigate: (path, state) => {
        // http://es6-features.org/#SpreadOperator
        this.setState({ ...state, path: path })
      }
    }

    if (this.state.path === "/") {
      content = (<CreateCartForm router={router} />)
    } else if (this.state.path === "/catalog") {
      content = (<CatalogView
        router={router}
        cartID={this.state.cartID}
        catalog={this.state.catalog}
        cartContent={this.state.cartContent}
        refreshCart={this.refreshCart}
      />)
    } else if (this.state.path === "/cart") {
      content = (<CartView
        router={router}
        username={this.state.username}
        password={this.state.password}
        cartID={this.state.cartID}
        catalog={this.state.catalog}
        cartContent={this.state.cartContent}
        refreshCart={this.refreshCart}
      />)
    } else if (this.state.path === "/purchrases") {
      content = (<PurchrasesView
        router={router}
        username={this.state.username}
        password={this.state.password}
        catalog={this.state.catalog}
      />)
    } else if (this.state.path === "/book") {
      content = (<BookView
        book={this.state.selectedBook}
        cartID={this.state.cartID}
        cartContent={this.state.cartContent}
        refreshCart={this.refreshCart}
      />)
    }
    return (
      <div>
        <MyToolBar
          title={title}
          router={router}
          username={this.state.username}
        />
        <Container maxWidth="sm">
          <div style={{ marginTop: 24, }}>
            {content}
          </div>
        </Container>
      </div>
    );
  }
}
