print("Loading csv...")
df = read.csv(file="chicago_crimes.csv", sep=",")
print("Done loading!")

c_codes = df[["IUCR"]]
c_primary = df[["Primary.Type"]]
c_desc = df[["Description"]]

c_long_desc = paste(c_primary, c_desc, sep=" ")
names(c_codes) = c_long_desc

unique_codes = c_codes[!duplicated(names(c_codes))]
unique_codes = sort(c_codes)

write.table(unique_codes, file="ch_unique_codes.txt", sep="\t")
