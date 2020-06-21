import React from 'react'
import {makeStyles} from '@material-ui/core/styles'
import Card from '@material-ui/core/Card'
import CardActionArea from '@material-ui/core/CardActionArea'
import CardActions from '@material-ui/core/CardActions'
import CardContent from '@material-ui/core/CardContent'
import CardMedia from '@material-ui/core/CardMedia'
import Button from '@material-ui/core/Button'
import Typography from '@material-ui/core/Typography'

const useStyles = makeStyles({
    root: {
        width: 330,
    },
});

export default function MicropostCard(props) {
    const classes = useStyles();

    return ( 
      <Card className = {classes.root} >
        <CardActionArea >
          <CardMedia 
            component = "img" 
            alt = "Contemplative Reptile" 
            height = "140" 
            image = "/static/images/cards/contemplative-reptile.jpg" title = "Contemplative Reptile"
          />
          <CardContent >
            <Typography gutterBottom variant = "h5" component = "h2" >
               {props.data.facility_name}
               {/* {props.data.picture.url}
               <img src = "https://www.petio.com/wp-content/uploads/2020/01/cat/02/content06_img.jpg"/> */}
            </Typography> 
            <Typography variant = "body2" color = "textSecondary" component = "p" >
              {props.data.content} 
            </Typography> 
          </CardContent> 
        </CardActionArea> 
        <CardActions >
           <Button size = "small" color = "primary" >Share </Button> 
           <Button size = "small" color = "primary" >Learn More </Button> 
        </CardActions> 
      </Card>
    );
}
