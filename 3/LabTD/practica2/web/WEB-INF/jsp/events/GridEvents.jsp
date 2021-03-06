<%--
    Document   : GridAssistances
    Created on : 19-abr-2012, 12:00:05
    Author     : javier
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="stripes"
           uri="http://stripes.sourceforge.net/stripes.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<stripes:layout-render name="/WEB-INF/jsp/common/Layout.jsp" view="Grid">
    <stripes:layout-component name="bodypage">
	<stripes:messages/>
	<table>
	    <thead>
		<tr>
		    <th>Id</th>
		    <th>Temporada</th>
		    <th>Tipo</th>
		    <th>Fecha del evento</th>
		    <th>Asistentes esperados</th>
		    <th>Asistentes totales</th>
		    <th>Asistentes puntuales</th>
		    <th>Asistentes impuntuales</th>
		    <th>Acciones</th>
		</tr>
	    </thead>
	    <!--Se me ha ocurrido que para evitar pegarme con si la abstracción de la base de datos está bien
	    o mal, puedo coger y hacerlo como un TreeMap, de tal manera que me vengan en orden los elementos
	    y además, pueda refererirme a los elementos como tales.-->
	    <tbody>
		<stripes:form beanclass="org.lmb97.web.action.EventsActionBean">
		    <c:forEach var="Event" items="${actionBean.events}" varStatus="loop">
			<tr>
			    <td>
				${Event.id}
			    </td>
			    <td>
				<stripes:select name="events[${loop}].season" value="${Event.season}" disabled="${actionBean.readonly}">
				    <stripes:options-collection collection="${actionBean.seasons}" value="id"/>
				</stripes:select>
			    </td>
			    <td>
				<stripes:select name="events[${loop}].eventType" value="${Event.eventType}" disabled="${actionBean.readonly}">
				    <stripes:options-collection collection="${actionBean.eventTypes}"
								label="name" value="id"/>
				</stripes:select>
			    </td>
			    <td>
				<stripes:text name="events[${loop}].date" value="${Event.date}"
					      formatPattern="yyyy/MM/dd HH:mm" disabled="${actionBean.readonly}"/>
			    </td>
			    <td>
				<center>${actionBean.expectedassistants[Event.id]}</center>
			    </td>
			    <td>
				<center>${actionBean.totalassistants[Event.id]}</center>
			    </td>
			    <td>
				<center>${actionBean.ontimeassistants[Event.id]}</center>
			    </td>
			    <td>
				<center>${actionBean.totalassistants[Event.id] - actionBean.ontimeassistants[Event.id]}</center>
			    </td>
			    <td>
				<stripes:link beanclass="org.lmb97.web.action.EventsActionBean" event="viewForm" >
				    <stripes:param name="id" value="${Event.id}"/>
				    Ver
				</stripes:link>
				<stripes:link beanclass="org.lmb97.web.action.EventsActionBean" event="modifyForm" >
				    <stripes:param name="id" value="${Event.id}"/>
				    Modificar
				</stripes:link>
			    </td>
			    <td>
				<stripes:errors field="Event.eventType" />
			    </td>
			</tr>
		    </c:forEach>
		</stripes:form>
		<stripes:form beanclass="org.lmb97.web.action.EventsActionBean">
		    <tr>
			<td></td>
			<td>
			    <stripes:select name="event.season">
				<stripes:options-collection collection="${actionBean.seasons}" value="id"/>
			    </stripes:select>
			</td>
			<td>
			    <stripes:select name="event.eventType" >
				<stripes:options-collection collection="${actionBean.eventTypes}"
							    label="name" value="id"/>
			    </stripes:select>
			</td>
			<td>
			    <stripes:text name="event.date" formatPattern="yyyy/MM/dd HH:mm" />
			</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>
			    <stripes:submit name="insertForm">Insertar</stripes:submit>
			</td>
		    </tr>
		</stripes:form>
	    </tbody>
	</table>
    </stripes:layout-component>
</stripes:layout-render>