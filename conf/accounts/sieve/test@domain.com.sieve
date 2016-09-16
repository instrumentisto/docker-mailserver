require "fileinto";

if address :contains "From" "dockermailserver@external.tld"
{
    fileinto "Trash";
}
