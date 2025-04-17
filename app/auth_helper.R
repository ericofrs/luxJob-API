auth_helper <- function(
    res,
    req,
    FUN,
    ...
) {
  # Check if Authorization header exists
  req_has_key <- "HTTP_AUTHORIZATION" %in% names(req)
  
  if (req_has_key) {
    # Extract the token from the Authorization header
    # Format should be "Bearer <token>"
    auth_header <- req$HTTP_AUTHORIZATION
    token_parts <- strsplit(auth_header, " ")[[1]]
    
    # Check if it's a Bearer token and extract the actual token
    if (length(token_parts) == 2 && token_parts[1] == "Bearer") {
      supplied_token <- token_parts[2]
      
      # Check if token matches
      key_is_valid <- verify_token(supplied_token)
      
      # Second check, when the TOKEN was in the .Renviron
      # environment_not_set <- nchar(Sys.getenv("TOKEN")) <= 1
      
      if (key_is_valid) {
        adjust_quota(supplied_token)
        return(FUN(...))
      }
    }
  }
  
  # If we get here, authentication failed
  res$body <- "Unauthorized"
  res$status <- 401
  return("Missing or invalid Bearer token, or invalid configuration!")
}