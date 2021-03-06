# Rain or Shine
A mobile iOS app that recommends outfits to users based on weather and other information

## API Specification
### Get all outfits
**GET** `/api/outfits/`  
Success Response:  
`{
    "success": true,
    "data": [
        {
            "id": 1,
            "season": "summer",
            "gender": "male",
            "weather": "sunny",
            "temp": "hot",
            "url": "https://cs1998-rainorshine.s3-us-east-2.amazonaws.com/MQ3CC286V7DU172S.png",
            "created_at": "2020-12-12 16:15:34.138294"
        }
    ]
}`

### Get specific outfit(s)
**GET** `/api/outfits/{gender}/{season}/{weather}/{temperature}/`  
Success Response:  
`{
    "success": true,
    "data": [
        {
            "id": 1,
            "gender": "male",
            "season": "summer",
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
    "gender": "male",
    "season": "summer",
    "weather": "sunny",
    "temp": "hot",
    "image_data": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABAQMAAAAl21bKAAAAA1BMVEUAAACnej3aAAAAAXRSTlMAQObYZgAAAApJREFUCNdjYAAAAAIAAeIhvDMAAAAASUVORK5CYII="
}`  
Success Response:  
`{
  "success": true,
  "data": [
    {
      "id": 7,
      "gender": "female",
      "season": "winter",
      "weather": "snowy",
      "temp": "cold",
      "url": "https://cs1998-rainorshine.s3-us-east-2.amazonaws.com/3TGWWOWEGPYVM6F2.jpg",
      "created_at": "2020-12-14 12:49:34.059924"
    },
    {
      "id": 8,
      "gender": "female",
      "season": "winter",
      "weather": "snowy",
      "temp": "cold",
      "url": "https://cs1998-rainorshine.s3-us-east-2.amazonaws.com/W3JPBLCHI4T0HUCB.jpg",
      "created_at": "2020-12-14 12:49:40.844229"
    }
  ]
}`

### Delete specific outfit
**DELETE** `/api/outfits/{id}/`  
Success Response:  
`{
    "success": true,
    "data": {
        "id": 1,
        "season": "summer",
        "gender": "male",
        "weather": "sunny",
        "temp": "hot",
        "url": "https://cs1998-rainorshine.s3-us-east-2.amazonaws.com/MQ3CC286V7DU172S.png",
        "created_at": "2020-12-12 16:15:34.138294"
    }
}`
