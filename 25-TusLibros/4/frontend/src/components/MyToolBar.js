function MyToolBar(props) {
  const classes = useStyles();
  const {title, router, username } = props;

  let logoutButton = ( <IconButton
    edge="start"
    className={classes.menuButton}
    color="inherit"
    onClick={()=>router.navigate("/", { username: null, cartID: null })}
  >
    <Icon>exit_to_app</Icon>
  </IconButton>
  )

  let cartButton = ( <IconButton
    edge="end"
    className={classes.menuButton}
    color="inherit"
    onClick={()=>router.navigate("/cart")} >

    <Icon>shopping_cart</Icon>
  </IconButton>
  )

  let storeButton = ( <IconButton
    edge="end"
    className={classes.menuButton}
    color="inherit"
    onClick={()=>router.navigate("/catalog")} >

    <Icon>store</Icon>
  </IconButton>
  )

  if (router.current() === "/") {
    logoutButton= null
    cartButton = null
    storeButton = null
  }

  return (
    <div className={classes.rootToolBar}>
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" className={classes.title}>
            {title} - {username}
          </Typography>
          {storeButton}
          {cartButton}
          {logoutButton}
        </Toolbar>
      </AppBar>
    </div>
  )
}
