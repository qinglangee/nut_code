public classs F101_FileStream{
    public static void main(String[] args){
        long numberOfLines = 
        Files.lines(Paths.get("yourFile.txt"), Charset.defaultCharset())
            .count();
    }
}