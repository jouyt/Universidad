package org.lmb97.data;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.lmb97.data.People;
import org.lmb97.data.PeopleExample;

public interface PeopleMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table people
     *
     * @mbggenerated Tue May 15 11:58:16 CEST 2012
     */
    int countByExample(PeopleExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table people
     *
     * @mbggenerated Tue May 15 11:58:16 CEST 2012
     */
    int deleteByExample(PeopleExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table people
     *
     * @mbggenerated Tue May 15 11:58:16 CEST 2012
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table people
     *
     * @mbggenerated Tue May 15 11:58:16 CEST 2012
     */
    int insert(People record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table people
     *
     * @mbggenerated Tue May 15 11:58:16 CEST 2012
     */
    int insertSelective(People record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table people
     *
     * @mbggenerated Tue May 15 11:58:16 CEST 2012
     */
    List<People> selectByExample(PeopleExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table people
     *
     * @mbggenerated Tue May 15 11:58:16 CEST 2012
     */
    People selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table people
     *
     * @mbggenerated Tue May 15 11:58:16 CEST 2012
     */
    int updateByExampleSelective(@Param("record") People record, @Param("example") PeopleExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table people
     *
     * @mbggenerated Tue May 15 11:58:16 CEST 2012
     */
    int updateByExample(@Param("record") People record, @Param("example") PeopleExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table people
     *
     * @mbggenerated Tue May 15 11:58:16 CEST 2012
     */
    int updateByPrimaryKeySelective(People record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table people
     *
     * @mbggenerated Tue May 15 11:58:16 CEST 2012
     */
    int updateByPrimaryKey(People record);
}