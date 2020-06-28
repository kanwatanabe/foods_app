import React, { useEffect } from "react"
import { makeStyles } from '@material-ui/core/styles'
import Modal from '@material-ui/core/Modal'
import TextareaAutosize from '@material-ui/core/TextareaAutosize'

import Paper from '@material-ui/core/Paper'
import Grid from '@material-ui/core/Grid'
import GridList from '@material-ui/core/GridList'

// import PropTypes from "prop-types"

// モーダルの位置------------------------------------------
function rand() {
  return Math.round(Math.random() * 20) - 10;
}

function getModalStyle() {
  const top = 50 + rand();
  const left = 50 + rand();

  return {
    top: `${top}%`,
    left: `${left}%`,
    transform: `translate(-${top}%, -${left}%)`,
  };
}

// user名　取得----------------------------------------------
function getUserName(props) {
   $.ajax({
         url: 'http://localhost:3000/micropost',
         type: 'GET',
         dataType: 'json',
         cache: false,
         data: {
           user_id: props.user_id
         }})
      .then((data) => {

        this.setState({name: data.user.name})

      })

}
// --------------------------------------------------------

const useStyles = makeStyles((theme) => ({
  root: {
    flexGrow: 1,
  },
  paper: {
    padding: theme.spacing(2),
    textAlign: 'center',
    color: theme.palette.text.secondary,
  },
  modal: {
    position: 'absolute',
    width: 500,
    backgroundColor: theme.palette.background.paper,
    border: '2px solid #000',
    boxShadow: theme.shadows[5],
    padding: theme.spacing(2, 4, 3),
  },
  gridList: {
    maxWidth: "xs",
    height: 450,
  },
}))


export default function NotLoginComments(props) {
  const classes = useStyles();
  const [modalStyle] = React.useState(getModalStyle);
  const [open, setOpen] = React.useState(false);

  const handleOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };

// user名　取得--------------------------------------------
  useEffect(() => {
     getUserName(props.comment.user_id);
  })

  
// --------------------------------------------------------
  const body = (
    <div style={modalStyle} className={classes.modal}>
    <GridList GridList Container cellHeight = {160} className = {classes.gridList} >
      <div className={classes.root}>
        <Grid container spacing={3}>

          <Grid item xs = {12} >
             {props.comments.map( (comment) => {
            return ( 
                 
                <Paper className={classes.paper}>{comment.content}
                <p>{state.name}</p>
                </Paper>
                
              
                )
            })
        } 
          </Grid>
        </Grid>
      </div>  
      </GridList>
      
      <div className="mt-5">
      <TextareaAutosize
      item xs={12}
      aria-label="maximum height"
      placeholder = "コメントを入力してください"

    />
    </div>
    </div>
  );

    return (
    <div>
      <button type="button" onClick={handleOpen}>
        コメント
      </button>
      <Modal
        open={open}
        onClose={handleClose}
        aria-labelledby="simple-modal-title"
        aria-describedby="simple-modal-description"
      >
      {body}
      </Modal>
    </div>
    )
};

