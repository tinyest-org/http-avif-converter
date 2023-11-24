import requests

def test():
    r = requests.post('http://localhost:8100/upload', files={"file": open("color.png", 'rb')})
    with open("result.avif", 'wb') as f:
        f.write(r.content)


test()