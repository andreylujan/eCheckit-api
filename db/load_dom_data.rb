
require 'digest'
old_md5sum = nil
if File.file? ENV['MD5SUM_FILE']
  f = File.open(ENV['MD5SUM_FILE'], 'r')
  old_md5sum = f.read
  f.close
end
md5sum = Digest::MD5.file(ENV['DATA_FILE']).hexdigest
if not old_md5sum.nil? and old_md5sum == md5sum
  exit
end

require 'csv'
def titleize(word)
  word.humanize.gsub(/\b(?<!['’`])[a-z]/) { $&.capitalize }
end

Client.transaction do

  Contact.destroy_all
  Construction.destroy_all
  Client.destroy_all

  CSV.foreach(ENV['DATA_FILE'], { col_sep: ';', encoding: 'windows-1251:utf-8' }) do |row|
    if row.length >= 4
      client_data = {
        rut: row[0],
        name: row[1],
        construction_name: row[2],
        construction_id: row[3]
      }
      if row.length >= 5
        client_data[:contact_name] = row[4]
      end

      if row.length >= 6
        client_data[:contact_email] = row[5]
      end

      if row.length >= 7
        client_data[:construction_address] = row[6]
      end

      client_data.values.each do |val|
        val.strip! if val.present?
      end

      if client_data[:rut].nil? or client_data[:construction_id].nil? or
        /(\d)+-./.match(client_data[:rut]).nil?
        # ap client_data
        next
      end
      client_data[:rut].upcase!
      client_data[:contact_email].downcase! if client_data[:contact_email].present?
      client_data[:name] = titleize(client_data[:name]) if client_data[:name].present?
      client_data[:construction_name] = titleize(client_data[:construction_name]) if client_data[:construction_name].present?
      client_data[:construction_id] = client_data[:construction_id].to_i
      client_data[:construction_address] = titleize(client_data[:construction_address]) if client_data[:construction_address].present?
      client_data[:contact_name] = titleize(client_data[:contact_name]) if client_data[:contact_name].present?

      client = Client.with_deleted.find_by_rut(client_data[:rut])
      if client.present?
        client.restore
      end

      client = Client.find_or_create_by(rut: client_data[:rut], workspace_id: 206).tap do |c|
        c.name = client_data[:name]
        c.save!
      end

      construction = Construction.with_deleted.find_by_unique_id_and_client_id(client_data[:construction_id],
                                                                               client.id)
      if construction.present?
        construction.restore
      end
      construction = Construction.find_or_create_by(unique_id: client_data[:construction_id], client: client).tap do |c|
        c.name = client_data[:construction_name]
        c.address = client_data[:construction_address]
        c.save!
      end

      if client_data[:contact_email].present?

        contact = Contact.with_deleted.find_by_email_and_construction_id(client_data[:contact_email],
                                                                         construction.id)
        if contact.present?
          contact.restore
        end

        Contact.find_or_create_by(email: client_data[:contact_email], construction: construction).tap do |c|
          c.name = client_data[:contact_name].present? ? client_data[:contact_name] : client_data[:contact_email]
          c.save!
        end
      end
    end

  end
end

f = File.open(ENV['MD5SUM_FILE'], 'w')
f.write md5sum
f.close
