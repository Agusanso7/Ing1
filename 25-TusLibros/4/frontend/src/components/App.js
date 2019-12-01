class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      path: "/",
      username: '',
      cartID: null,
      cartContent: []
    };
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
        username={this.state.username}
        cartID={this.state.cartID}
      />)
    } else if (this.state.path === "/details") {
      content = (<SubstringDetailsView
        router={router}
        selectedSubstring={this.state.selectedSubstring}
      />)
    }
    return (
      <div>
        <MyToolBar
          title={title}
          router={router}
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
