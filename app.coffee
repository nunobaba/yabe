# Yabe
# version 0.0.1

connect = require 'connect'
assets  = require 'connect-assets'
express = require 'express'
jade    = require 'jade'
stylus  = require 'stylus'

app     = express.createServer()


# CONFIGURATION

app.configure ->
	app.use assets()

	# Set the path to views
	app.set 'views', __dirname + '/views'

	# Overriding the use of rendered elements into tree
	app.set 'view options', layout: false

	# Set Jade as default template engine
	app.set 'view engine', 'jade'

	# Parse body parts
	app.use connect.bodyParser()

	# Static file server with the given root path
	app.use connect.static( '#{__dirname}/public' )

	# Log requests
	app.use express.logger()

	# Compile on demand coffeescripts to js
	app.use express.compiler( src: __dirname + '/assets'
							, dest: __dirname + '/public'
							, enable: ['coffeescript'] ) 

	# Set stylus to autocompile
	# found http://stackoverflow.com/a/6552758
	app.use stylus.middleware
		debug: true
		force: true
		src: "#{__dirname}/../public"
		dest: "#{__dirname}/../public"


# ROUTES

app.get '/', ( req, res ) -> 
	res.render 'chrome'

# Launching the app
app.listen 4040
console.log 'Check localhost:%d', app.address().port
