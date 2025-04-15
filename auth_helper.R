auth_helper <- function(
    res,
    req,
    FUN,
    ...
) {
  req_has_key <- "HTTP_X_WORKSHOP_KEY" %in% names(req)
  key_is_valid <- req$HTTP_X_WORKSHOP_KEY == Sys.getenv("WORKSHOP_KEY")
  environment_not_set <- nchar(Sys.getenv("WORKSHOP_KEY")) <= 1
  if (!req_has_key || !key_is_valid || environment_not_set) {
    res$body <- "Unauthorized"
    res$status <- 401
    "Missing or invalid API key, or invalid configuration!"
  } else {
    FUN(...)
  }
}