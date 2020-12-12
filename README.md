# Rain or Shine
A mobile iOS app that recommends outfits to users based on weather and other information

## API Specification
### Get outfits
**GET** `/api/outfits/`  
Success Response:  
`{
    "success": true,
    "data": [
        {
            "id": 1,
            "name": "Primoz Roglic",
            "gender": "male",
            "weather": "sunny",
            "temp": "hot",
            "url": "https://cs1998-rainorshine.s3-us-east-2.amazonaws.com/MQ3CC286V7DU172S.png",
            "created_at": "2020-12-12 16:15:34.138294"
        }
    ]
}`

### Get specific outfit(s)
**GET** `/api/outfits/{gender}/{weather}/{temperature}/`  
Success Response:  
`{
    "success": true,
    "data": [
        {
            "id": 1,
            "name": "Primoz Roglic",
            "gender": "male",
            "weather": "sunny",
            "temp": "hot",
            "url": "https://cs1998-rainorshine.s3-us-east-2.amazonaws.com/MQ3CC286V7DU172S.png",
            "created_at": "2020-12-12 16:15:34.138294"
        }
    ]
}`

### Create outfit
**POST** `/api/outfits/`  
Request:  
`{
    "name": "Primoz Roglic",
    "gender": "male",
    "weather": "sunny",
    "temp": "hot",
    "image_data": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABAQMAAAAl21bKAAAAA1BMVEUAAACnej3aAAAAAXRSTlMAQObYZgAAAApJREFUCNdjYAAAAAIAAeIhvDMAAAAASUVORK5CYII="
}`  

Success Response:  
`{
    "success": true,
    "data": {
        "id": 2,
        "name": "Primoz Roglic",
        "gender": "male",
        "weather": "sunny",
        "temp": "hot",
        "url": "https://cs1998-rainorshine.s3-us-east-2.amazonaws.com/ZMNCDMCSRIL6TB5O.png",
        "created_at": "2020-12-12 16:25:45.955228"
    }
}`

### Delete specific outfit
**DELETE** `/api/outfits/{id}/`  
Success Response:  
`{
    "success": true,
    "data": {
        "id": 1,
        "name": "Primoz Roglic",
        "gender": "male",
        "weather": "sunny",
        "temp": "hot",
        "url": "https://cs1998-rainorshine.s3-us-east-2.amazonaws.com/MQ3CC286V7DU172S.png",
        "created_at": "2020-12-12 16:15:34.138294"
    }
}`
