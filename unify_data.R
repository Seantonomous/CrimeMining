library(dplyr)
#################################### LA -> UNIFIED CONVERSION ##########################################
print("Reading csvs...")
df <- read.csv(file="la_crimes.csv",sep=",")
df2 <- read.csv(file="la_to_ch_translate.csv",sep=",")

# Get only the rows with codes we want
codes <- df2[["LA.CODE"]]
descriptions <- df2[["UNIFIED.DESCRIPTION"]]
new_codes <- df2[["UNIFIED.CODE"]]

# Remove rows w/ codes we don't want
print("Removing rows w/ codes we can't use...")
df <- filter(df, Crime.Code %in% codes)

# Remove columns we don't want
df <- select(df, DR.Number, Date.Occurred, Time.Occurred, Crime.Code, Crime.Code.Description)

names(descriptions) = codes
names(new_codes) = codes

print("Replacing codes & descriptions...")

df$Crime.Code.Description <- unname(descriptions[as.character(df$Crime.Code)])
df$Crime.Code <- unname(new_codes[as.character(df$Crime.Code)])

print("Writing csv...")
write.csv(x=df,file="la_cleaned_for_compare.csv",row.names = FALSE)
print("Done!")

#################################### CH -> UNIFIED CONVERSION ##########################################
print("Reading csvs...")
df <- read.csv(file="chicago_crimes.csv",sep=",")
df2 <- read.csv(file="ch_to_la_translate.csv",sep=",")

# Get only the rows with codes we want
codes <- df2[["CH.CODE"]]
descriptions <- df2[["UNIFIED.DESCRIPTION"]]
new_codes <- df2[["UNIFIED.CODE"]]

# Remove columns we don't want
df <- select(df, ID, Date, IUCR)

# Rename columns to unified format
colnames(df) <- c("ID", "Date", "Crime Code")

# Remove rows w/ codes we don't want
print("Removing rows w/ codes we can't use...")
df <- filter(df, df$`Crime Code` %in% codes)

names(descriptions) = codes
names(new_codes) = codes

print("Replacing codes & descriptions...")

df$Crime.Code.Description <- unname(descriptions[as.character(df$`Crime Code`)])
df$Crime.Code <- unname(new_codes[as.character(df$`Crime Code`)])

print("Writing csv...")
write.csv(x=df,file="ch_cleaned_for_compare.csv",row.names = FALSE)
print("Done!")
