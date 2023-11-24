# http converter AVIF

An ultra basic http wrapper for kagami-avif

Will convert a png or jpeg from a post request to an avif file 

```sh
curl -X POST -F "file=@color.png" http://localhost:8100/upload
```