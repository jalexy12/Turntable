

var UserList = React.createClass({

	componentDidMount: function(){
	   var channel = pusher.subscribe(this.props.room);

        channel.bind('userjoinroom', function(data) {
        if (!("Notification" in window)) {
          alert("This browser does not support desktop notification");
        }
        else if (Notification.permission !== 'denied') {
          Notification.requestPermission(function (permission) {
            if (permission === "granted") {
              var notification = new Notification(data.newuseralert);
            }
          });
        }
      });
	},
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