
f = File.open("./db/checklists.csv", "w")

f << "Descripción,Concordancia\n"
Checklist.all.each do |checklist|
    f << checklist.name << "\n"
    checklist.checklist_categories.each do |category|
        f << category.name << "\n"
        category.checklist_items.each do |item|
            f << item.name << "\n"
        end
    end
end

f.close