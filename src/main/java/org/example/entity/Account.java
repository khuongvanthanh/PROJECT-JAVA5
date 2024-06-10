package org.example.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "Accounts")
public class Account {
    @Id
    @Size(max = 100)
    @NotBlank(message = "username not null")
    @Column(name = "Username", length = 100)
    private String username;

    @Size(max = 100)
    @NotBlank(message = "Password not null")
    @Column(name = "password", length = 100)
    private String password;

    @Size(max = 100)
    @NotBlank(message = "Fullname not null")
    @Column(name = "fullname", length = 100)
    private String fullname;

    @Size(max = 100)
    @NotBlank(message = "Email not null")
    @Column(name = "email", length = 100)
    private String email;

    @Size(max = 500)
    @Column(name = "photo", length = 500)
    private String photo;

    @NotNull(message = "Activated not null")
    @Column(name = "activated")
    private Byte activated;

    @Column(name = "admin")
    private Byte admin;

}