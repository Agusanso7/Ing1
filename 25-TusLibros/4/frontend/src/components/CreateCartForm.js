function CreateCartForm(props) {
  const { router } = props
  const classes = useStyles();

  const [values, setValues] = React.useState({
    username: '',
    password: '',
  });

  const [error, setError] = React.useState(false)

  const handleChange = prop => event => {
    setValues({ ...values, [prop]: event.target.value });
  };

  const handleSend = (username, password) => {
    createCart(username,password)
      .then(function (response) {
        if(!response.ok) {
          throw Error(response)
        }

        return response.json()
      })
      .then(function (json) {
        router.navigate("/catalog", { username: username, password: password, cartID: json.cart_id })
      })
      .catch(function (error) {
        setError(true)
        setValues({ username: '', password: ''})
      });
  };

  return (
    <div>
      <Typography component="h1" gutterBottom>
          Welcome to Tus Libros <i>(Your Books)</i>, where your dreams come true....
          </Typography>
      <Typography component="h2" gutterBottom>
          Login to begin having fun
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
              value={values.username}
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
            value={values.password}
            onChange={handleChange('password')}
          />
        </FormControl>

       { error &&
            <Typography component="p" color="error" gutterBottom>
                Invalid user or password
            </Typography>
        }

      <Button
      variant="contained"
        className={classes.Button}
        style={{float: 'right'}}
        color="primary"
        onClick={() => handleSend(values.username, values.password)}>
        >
          Login
          </Button>
      </form>
    </div>
  )
}
