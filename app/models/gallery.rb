require 'kramdown'
class Gallery < Post
  include MongoMapper::Document

  # Keys
  key :body,      String
  key :body_src,  String
  key :intro,     String
  key :intro_src, String     
  
  # Key Settings
  slug_key :title, :unique => true
  
  # Callbacks
  before_save   :generate_rendered
  before_update :update_rendered
  
  # Associations
  many :images   
  
  private     
  
    def generate_rendered()         
      return if body_src.blank? || intro_src.blank?      
      if self.body.blank? 
        self.body = Kramdown::Document.new(self.body_src).to_html  
      else
        return
      end   
      if self.intro.blank?  
        self.intro = Kramdown::Document.new(self.intro_src).to_html 
      else
        return
      end
    end   
    
    def update_rendered()         
      return if body_src.blank? || intro_src.blank? 
      self.body  = Kramdown::Document.new(self.body_src).to_html   
      self.intro = Kramdown::Document.new(self.intro_src).to_html   
    end  
   
end