function CreateCartForm(props) {
  const { router } = props
  const classes = useStyles();

  const [values, setValues] = React.useState({
    username: '',
    password: '',
  });

  const handleChange = prop => event => {
    setValues({ ...values, [prop]: event.target.value });
  };

  const handleSend = (username, password) => {
    createCart(username,password)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        router.navigate("/catalog", { username: username, password: password, cartID: json.cart_id })
      })
      .catch(function (error) {
        console.log('Looks like there was a problem: \n', error);
      });
  };

  return (
    <div>
      <Typography component="h1" gutterBottom>
        Bienvenido a Tus Libros, donde tus sueños se vuelven realidad....
          </Typography>
      <Typography component="h2" gutterBottom>
        Crea un carrito para comenzar
          </Typography>

     <form className={classes.container} noValidate autoComplete="off">

      <FormControl fullWidth className={classes.textField} variant="outlined">
          <TextField
              required
              id="outlined-required"
              label="User"
              className={classes.textField}
              margin="normal"
              variant="outlined"
              onChange={handleChange('username')}
            />
          <TextField
            required
            id="outlined-required"
            label="Password"
            className={classes.textField}
            margin="normal"
            variant="outlined"
            type="password"
            onChange={handleChange('password')}
          />
        </FormControl>

      <Button
      variant="contained"
        className={classes.Button}
        style={{float: 'right'}}
        color="primary"
        onClick={() => handleSend(values.username, values.password)}>
        >
          Create cart
          </Button>
      </form>
    </div>
  )
}
