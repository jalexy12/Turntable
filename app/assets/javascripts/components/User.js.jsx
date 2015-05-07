var UserList = React.createClass({
	render: function(){
		var users = this.props.users.map(function(user){
			return(
			  <div className="row"><User user={user} /><br /> </div>
			)
		})
		return (<div> {users} </div>)

	}
})


var User = React.createClass({
	render: function(){
		return(
			<div className="col s6"> 
				<img className="useravatar" src={this.props.user.avatar} />
				<span className="userheading">{this.props.user.email}</span>
			</div>
			)
	}
})