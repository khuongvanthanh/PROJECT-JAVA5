package org.example.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.util.Date;
@Getter
@Setter
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "Products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Size(max = 100)
    @NotBlank(message = "name not null")
    @Column(name = "name", length = 100)
    private String name;

    @Size(max = 100)
//    @NotBlank(message = "image not null")
    @Column(name = "image", length = 100)
    private String image;

    @NotNull(message = "price not null")
    @Min(value = 0,message = "price > 0")
    @Column(name = "price")
    private Double price;

//    @NotNull(message = "Category not null")
    @ManyToOne
    @JoinColumn(name = "Categoryid")
    private Category categoryId;

    @Column(name = "Createdate")
    private Date createdate;

    @Column(name = "available")
    private Byte available;

}