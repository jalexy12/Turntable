var User = React.createClass({
	render: function(){
		return(
			<div className="small 2 columns text-center"> 
				<h5 className="userheading row">{this.props.user.email}</h5>
				<img className="useravatar row" src={this.props.user.avatar} />
				<span className="usergenre row">Favorite genre: {this.props.user.favgenre} </span>
			</div>
			)
	}
})