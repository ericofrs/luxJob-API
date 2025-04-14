library(plumber)

#* @apiTitle Basic luxJob API
#* @apiDescription This is a simple API to demonstrate the use of luxJob
#* @apiVersion 1.0.0
#* @apiLicense MIT

#* Echo the parameter that was sent in
#* @param msg:string  The message to echo back.
#* @get /echo
#* @tag echo
function(msg=""){
  list(msg = paste0("The message is: '", msg, "'"))
}


#* Get books by id
#* @param book_id:int  The book id to be selected (1 to 1000)
#* @get /book
#* @tag Books
function(book_id=5){
  book_id <- as.integer(book_id)
  get_book_by_id(book_id)
}

#* Get book recommendations
#* @param skill:str If selected, the skill that it will filter for.
#* @get /book_recommendations
#* @tag Books
function(skill=NULL){
  get_books(skill)
}

#* Get company details
#* @param company_id:int  The company id to be selected.
#* @get /company_details
#* @tag Companies
function(company_id=1){
  company_id <- as.integer(company_id)
  get_company_details(company_id)
}

#* Get companies
#* @param limit:int If selected, it limits the number of rows.
#* @get /companies
#* @tag Companies
function(limit=100){
  limit <- as.integer(limit)
  get_companies(limit)
}

#* Get specific learning track
#* @param track_id:int  The learning track id to be selected.
#* @get /learning_track_detail
#* @tag Learning tracks
function(track_id){
  track_id <- as.integer(track_id)
  get_learning_track_by_id(track_id)
}

#* Get learning tracks
#* @param skill_id:str (url) If selected, it filters for the skill.
#* @get /learning_tracks
#* @tag Learning tracks
function(skill_id=NULL){
  get_learning_tracks(skill_id)
}

#* Get specific skill
#* @param company_id:int  The company id to be selected.
#* @get /selected_skill
#* @tag Skills
function(company_id=1){
  company_id <- as.integer(company_id)
  get_company_details(company_id)
}

#* Get skills
#* @param limit:int If selected, it limits the number of rows.
#* @param ordered:str yes or no. To sort the results alphabetically.
#* @get /skills
#* @tag Skills
function(limit=100, ordered){
  limit <- as.integer(limit)
  get_skills(limit, ordered)
}
