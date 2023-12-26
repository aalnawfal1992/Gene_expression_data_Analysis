##Basics of R
# Our WD
setwd("/Users/abdullahalnawfal/Desktop/Gene_expression_data")
# List file on WD as DF
files <- list.files()
# Print DF in our WD
print(files)
# remove created DF
rm(files)
# Install Rio package
install.packages("rio")
# Install tidyverse package (which includes several packages, including dplyr, ggplot2, tidyr, etc.)
install.packages("tidyverse")
# Install naniar package
install.packages("naniar")
# Install mice package
install.packages("mice")
# Install and load the pheatmap library if not already installed
if (!requireNamespace("pheatmap", quietly = TRUE)) {
  install.packages("pheatmap")
}
library(pheatmap)

####################################################
# Import our data as DF:
DataFrame <- read.csv("GSE143630_RCC_htseq_counts.txt",
              sep =" ",
              row.names = 1)
View(DataFrame)
####################################################
## Q1: Missing data 
# to print posation missung value on or DF
which(is.na(DataFrame))
# to count missing value in our DF
sum(is.na(DataFrame))
# To search in a specific colume
which(is.na(DataFrame$T1.1))
sum(is.na(DataFrame$T1.1))
# Another way
dim(DataFrame)
# Answer:
##there are no missing data in our DF
####################################################
## Q2: Number of R & C in DF
ncol(DataFrame)
nrow(DataFrame)
####################################################
## Q3
install.packages("naniar")
library(naniar)
pct_miss_case(DataFrame)
pct_complete_case(DataFrame)
####################################################
## Q4
# n of rows in DF containe T1 & T2
T1 = length(grep(x=colnames(DataFrame),pattern = "^T1"))
T2 = length(grep(x=colnames(DataFrame),pattern = "^T2"))
####################################################
## Q5
# Remove Rows with Any Zeros Using Base R
ZeroFreeDataFrame_A <- DataFrame[apply(DataFrame!=0, 1, all),]
# Another way to Remove Rows with Any Zeros Using dplyr
ZeroFreeDataFrame_B <- filter_if(DataFrame, is.numeric, all_vars((.) != 0))
####################################################
## Q6
# Sum the gene expression values for each stage (T1 and T2)
expression_sum_T1 <- sum(DataFrame[, grep("^T1", colnames(DataFrame))])
expression_sum_T2 <- sum(DataFrame[, grep("^T2", colnames(DataFrame))])
# Determine which stage has more gene expression
more_expression_stage <- ifelse(expression_sum_T1 > expression_sum_T2, "T1", "T2")
# Print the result
cat("Total gene expression for T1:", expression_sum_T1, "\n")
cat("Total gene expression for T2:", expression_sum_T2, "\n")
cat("The stage with more gene expression is:", more_expression_stage, "\n")
# Create a bar plot for better visualization
barplot(c(expression_sum_T1, expression_sum_T2), names.arg = c("T1", "T2"), col = c("yellow", "blue"), main = "Gene Expression Comparison", ylab = "Total Gene Expression")
####################################################
## Q7 
# Exclude the first column (gene names) and first row (sample ID)
gene_expression_data <- DataFrame[-1, -1]
# Convert data frame to numeric matrix
numeric_matrix <- as.matrix(gene_expression_data)
# Check dimensions of the matrix
matrix_dimensions <- dim(numeric_matrix)
print(matrix_dimensions)
# create a subset with the first 100 rows and first 100 columns
subset_matrix <- numeric_matrix[1:50, 1:43]
# Generate a heatmap for the first 50 genes
pheatmap(numeric_matrix, cluster_cols = FALSE, main = "Gene Expression Heatmap")
####################################################
## Q8
# Select the first 50 genes
subset_data <- DataFrame[1:51, ]
# Exclude the first column (gene names) and first row (sample ID)
gene_expression_data <- DataFrame[-1, -1]
# Convert data frame to numeric matrix
numeric_matrix <- as.matrix(gene_expression_data)
# Generate a heatmap for the first 50 genes
pheatmap(numeric_matrix, cluster_cols = FALSE, main = "Gene Expression Heatmap (First 50 Genes)")
####################################################
##Validation:
#To remove the last 5 rows
df <- DataFrame[1:(nrow(f) - 5), ]
print(tail(df, 6))
####################################################
