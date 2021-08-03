library(pacman)

pacman::p_load(tidyverse, ggplot2)

depth_1 <- read.table(snakemake@input[["dep1"]], 
                      col.names = c("ref", "pool", "position", "depth"), sep = "\t")


depth_2 <- read.table(snakemake@input[["dep2"]], 
                      col.names = c("ref", "pool", "position", "depth"), sep = "\t")


d1 <- depth_1 %>%
  select(pool, position, depth)

d2 <- depth_2 %>%
  select(pool, position, depth)


ds <- bind_rows('Pool 1' = d1, 'Pool 2' = d2, .id = "pools")


#colors <- c("1" = "steelblue", "2" = "maroon")

p1 <- ggplot(ds, aes(x = position, y = depth, fill = pools, color = pools)) +
  geom_col(position = "dodge") +
  geom_hline(aes(yintercept = 20, linetype = "20X coverage cut"), color = "azure4", size = 0.8) +
  scale_linetype_manual(values = "dashed") +
  labs(title = "Amplicon Coverage\n", x = "Genome position", y = "Depth") +
  scale_fill_manual("Pools", values = c("Pool 1" = "steelblue", "Pool 2" = "maroon")) + 
  scale_color_manual("Pools", values = c("Pool 1" = "steelblue", "Pool 2" = "maroon")) +
  scale_x_continuous(breaks = seq(0, 30000, by = 5000)) +
  theme_minimal() +
  theme(legend.title = element_blank(),
        plot.title = element_text(face = "bold", color = "darkgreen")) +
  guides(fill = guide_legend(override.aes = list(linetype = "blank")))

p1

ggsave(snakemake@output[["fig"]], p1)



