package com.ada.model.view;

/**
 * Created by Admin on 12/27/2017.
 */
public class GroupView {
    private Long id;
    private String groupName;
    private String description;
    private String listAuthority;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getListAuthority() {
        return listAuthority;
    }

    public void setListAuthority(String listAuthority) {
        this.listAuthority = listAuthority;
    }
}
