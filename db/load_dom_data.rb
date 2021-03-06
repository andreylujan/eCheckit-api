require 'csv'


def titleize(word)
  word.humanize.gsub(/\b(?<!['’`])[a-z]/) { $&.capitalize }
end

Contact.destroy_all
Construction.destroy_all
Client.destroy_all

CSV.foreach('./db/DATOS.csv', { col_sep: ';', :encoding => 'windows-1251:utf-8' }) do |row|
  if row.length >= 4
    client_data = {
      rut: row[0],
      name: row[1],
      construction_name: row[2],
      construction_id: row[3]
    }
    if row.length >= 5
      client_data[:contact_email] = row[4]
    end
    if row.length >= 6
      client_data[:construction_address] = row[5]
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

    client = Client.with_deleted.find_by_rut(client_data[:rut])
    if client.present?
      client.restore
    end

    client = Client.find_or_create_by(rut: client_data[:rut], workspace_id: 206) do |c|
      c.name = client_data[:name]
    end

    construction = Construction.with_deleted.find_by_unique_id_and_client_id(client_data[:construction_id],
                                                                             client.id)
    if construction.present?
      construction.restore
    end
    construction = Construction.find_or_create_by(unique_id: client_data[:construction_id], client: client) do |c|
      c.name = client_data[:construction_name]
      c.address = client_data[:construction_address]
    end

    if client_data[:contact_email].present?

      contact = Contact.with_deleted.find_by_email_and_construction_id(client_data[:contact_email],
                                                                               construction.id)
      if contact.present?
        contact.restore
      end
      
      Contact.find_or_create_by(email: client_data[:contact_email], construction: construction) do |c|
        c.name = c.email if not c.name.present?
      end
    end
  end

end
