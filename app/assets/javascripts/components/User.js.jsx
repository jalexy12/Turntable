

var UserList = React.createClass({

	getInitialState: function (){
		return {users: this.props.users}
	},

	handleAdd: function(user){
		Users.addUser(user);
		return this.setState({users: Users.users});
	},

	handleRemove: function (user){
		var users = _.without(this.state.users, user)
		$.post('/room/' + this.props.room +  '/remove/' + user.id)
		return this.setState({users: users})
	},

	componentDidMount: function(){
	   var that = this;
	   // window.addEventListener('unload')
	   var channel = pusher.subscribe(this.props.room);
	},

	render: function(){
		console.log(this.state.users)
		var users = this.state.users.map(function(user){
		  var boundClick = this.handleRemove.bind(this, user);
			return(
			  <div className="row">
			    <User user={user} onClick={boundClick} /><br /> 
			  </div>
			)
		}, this)
		return (<div> {users} </div>)

	}
})


var User = React.createClass({
	render: function(){
		return(
			<div className="col s6"> 
				<img className="useravatar" src={this.props.user.avatar} />
				<span className="userheading">{this.props.user.email}</span>
				<button className="userbutton" onClick={this.props.onClick}>Remove</button>
			</div>
			)
	}
})