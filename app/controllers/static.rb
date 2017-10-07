require 'uri'

get '/' do
  return erb :"static/index"
end

def shorten(long)
  alphabet = ('A' .. 'Z').to_a.concat(('a' .. 'z').to_a)
  randomized = (0 .. 8).map { | | alphabet[rand(alphabet.length)]  }
  return randomized
end

post '/submit' do
  link = params[:link]
  if link =~ URI::regexp # && check no error code from link
    oldEntry = Url.find_by(full: link)
    if oldEntry.nil? # Site not already in database
      newEntry = Url.new(full: link, short: shortLink)
      newEntry.save
      #newEntry.short
      redirect('/')
    else # URL in database already
      #oldEntry.short
      status(400)
      body('400: Link already in database')
    end
  else
    status(400)
    body('400: Invalid link')
  end
end

get '/list' do
  entries = Url.all.map do |row|
    "<td>#{row.short}</td><td>#{row.full}</td>"
  end.join('')
  "<table border=1>#{entries}</table>"
end

get '/:string' do  
  entry = Url.find_by(short: params[:string])
  if (!entry.nil?)
    redirect(entry.full)
  else
    status(400)
    body('404: Invalid link')
  end
end

