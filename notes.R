l <- list(df1, df2)
l$medicare
l[[table]]
[[]] - get table from list

l <- lapply(c("file1", "file2"),
            function(filename) {
              read_csv(filename)
            }
  
  first parameter is vector or list that you iterate over

  sapply - simplify thing it gives back to you
  
  mapply - multiple apply, apply to more than one vector