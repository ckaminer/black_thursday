require 'csv'

class Loader

  def self.open_file(file_path)
    CSV.open file_path, headers: true, header_converters: :symbol
  end

end
