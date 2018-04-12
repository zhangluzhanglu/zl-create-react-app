import React from 'react';


class Demo extends React.Component
{
	render(){
		let demoIcoAddr="images/welcome.png";
		return (<div className="Demo">
		<h1>欢迎使用 zl_create-react-app 脚手架</h1>
		<img src={demoIcoAddr} />
		</div>);
	}
} 

export default Demo ;