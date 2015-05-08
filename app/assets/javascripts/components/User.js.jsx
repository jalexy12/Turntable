var UserList = React.createClass({

	getInitialState: function (){
		return {
			users: this.props.users,
		}
	},

	handleRemove: function (data){
		$.post('/room/' + this.props.room +  '/remove/' + data.id)
	},
	updateUserState: function (data){
		return this.setState({users: data.users})
	},

	componentDidMount: function(){
	   var that = this;
	   channel = pusher.subscribe('private-' + this.props.room)

	   channel.bind('client-userleave', function(data){
	   		that.updateUserState(data)
		});

	   channel.bind('client-userjoin', function(data){
	   		that.updateUserState(data)
	   });
	},

	render: function(){
		  if (this.state.users !== null){
			var users = this.state.users.map(function(user){
			  var boundClick = this.handleRemove.bind(this, user);
				return(
				  <div className="row">
				    <User user={user} onClick={boundClick} /><br /> 
				  </div>
				)
			}, this)
		}
		return (<div> {users} </div>)

	}
})


var User = React.createClass({
	render: function(){
		return(
			<div className="col s6 text-center"> 
				<img className="useravatar" src={this.props.user.avatar} />
				<span className="userheading">{this.props.user.email}</span>
				<button className="userbutton" onClick={this.props.onClick}>Remove</button>
			</div>
			)
	}
})