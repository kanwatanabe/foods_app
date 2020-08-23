import React from "react"
// import axios from 'axios'
import NotLoginComments from './NotLoginComments'

class CommentModal extends React.Component{

    constructor(props) {
      super(props)
      this.state = {
        names: [],
      }
      
    }

    componentDidMount(){
       axios.get('http://localhost:3000/user')

       .then((results) => {
           console.log(results)
           this.setState({
             names: results.data
           })
         })
         .catch((data) => {
           console.log(data)
         })
    }

    render(){
        return(
            <div>
              <NotLoginComments userData={this.state.names} />
            </div>
        );
    }
}
export default CommentModal