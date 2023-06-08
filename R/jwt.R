library(jose)


secret <- Sys.getenv("DS_JWT_SECRET")

# token <- jwt_claim(name = "jeroen", session = 123456)
# sig <- jwt_encode_hmac(token, secret)
# jwt_decode_hmac(sig, mysecret)


sig <- "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdXRoT3JnIjoianBtYXJpbmRpYXoiLCJhdXRoVG9rZW4iOiJuVk5hRGJYcXlncGo4NG9RIiwiaWF0IjoxNjg1MTIzNTM0fQ.8JUm_LbLgvIx3KWyfvCb28lxBvdL-blbkRWobFG1Mu8"
jwt_decode_hmac(sig, secret)


