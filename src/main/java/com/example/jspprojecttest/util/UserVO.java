package com.example.jspprojecttest.util;

public class UserVO {
    private int id;
    private String name;
    private int age;
    private String email;

    // 기본 생성자
    public UserVO() {}

    // 생성자
    public UserVO(int id, String name, int age, String email) {
        this.id = id;
        this.name = name;
        this.age = age;
        this.email = email;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "UserVO [id=" + id + ", name=" + name + ", age=" + age + ", email=" + email + "]";
    }
}
