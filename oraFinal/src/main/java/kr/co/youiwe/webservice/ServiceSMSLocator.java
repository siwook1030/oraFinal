/**
 * ServiceSMSLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package kr.co.youiwe.webservice;

public class ServiceSMSLocator extends org.apache.axis.client.Service implements kr.co.youiwe.webservice.ServiceSMS {

	private static final long serialVersionUID = 3710207790493528682L;

	public ServiceSMSLocator() {
    }


    public ServiceSMSLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public ServiceSMSLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for ServiceSMSSoap
    private java.lang.String ServiceSMSSoap_address = "http://webservice.youiwe.co.kr/SMS.v.6/ServiceSMS.asmx";

    public java.lang.String getServiceSMSSoapAddress() {
        return ServiceSMSSoap_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String ServiceSMSSoapWSDDServiceName = "ServiceSMSSoap";

    public java.lang.String getServiceSMSSoapWSDDServiceName() {
        return ServiceSMSSoapWSDDServiceName;
    }

    public void setServiceSMSSoapWSDDServiceName(java.lang.String name) {
        ServiceSMSSoapWSDDServiceName = name;
    }

    public kr.co.youiwe.webservice.ServiceSMSSoap getServiceSMSSoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(ServiceSMSSoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getServiceSMSSoap(endpoint);
    }

    public kr.co.youiwe.webservice.ServiceSMSSoap getServiceSMSSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            kr.co.youiwe.webservice.ServiceSMSSoapStub _stub = new kr.co.youiwe.webservice.ServiceSMSSoapStub(portAddress, this);
            _stub.setPortName(getServiceSMSSoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setServiceSMSSoapEndpointAddress(java.lang.String address) {
        ServiceSMSSoap_address = address;
    }


    // Use to get a proxy class for ServiceSMSSoap12
    private java.lang.String ServiceSMSSoap12_address = "http://webservice.youiwe.co.kr/SMS.v.6/ServiceSMS.asmx";

    public java.lang.String getServiceSMSSoap12Address() {
        return ServiceSMSSoap12_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String ServiceSMSSoap12WSDDServiceName = "ServiceSMSSoap12";

    public java.lang.String getServiceSMSSoap12WSDDServiceName() {
        return ServiceSMSSoap12WSDDServiceName;
    }

    public void setServiceSMSSoap12WSDDServiceName(java.lang.String name) {
        ServiceSMSSoap12WSDDServiceName = name;
    }

    public kr.co.youiwe.webservice.ServiceSMSSoap getServiceSMSSoap12() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(ServiceSMSSoap12_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getServiceSMSSoap12(endpoint);
    }

    public kr.co.youiwe.webservice.ServiceSMSSoap getServiceSMSSoap12(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            kr.co.youiwe.webservice.ServiceSMSSoap12Stub _stub = new kr.co.youiwe.webservice.ServiceSMSSoap12Stub(portAddress, this);
            _stub.setPortName(getServiceSMSSoap12WSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setServiceSMSSoap12EndpointAddress(java.lang.String address) {
        ServiceSMSSoap12_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     * This service has multiple ports for a given interface;
     * the proxy implementation returned may be indeterminate.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (kr.co.youiwe.webservice.ServiceSMSSoap.class.isAssignableFrom(serviceEndpointInterface)) {
                kr.co.youiwe.webservice.ServiceSMSSoapStub _stub = new kr.co.youiwe.webservice.ServiceSMSSoapStub(new java.net.URL(ServiceSMSSoap_address), this);
                _stub.setPortName(getServiceSMSSoapWSDDServiceName());
                return _stub;
            }
            if (kr.co.youiwe.webservice.ServiceSMSSoap.class.isAssignableFrom(serviceEndpointInterface)) {
                kr.co.youiwe.webservice.ServiceSMSSoap12Stub _stub = new kr.co.youiwe.webservice.ServiceSMSSoap12Stub(new java.net.URL(ServiceSMSSoap12_address), this);
                _stub.setPortName(getServiceSMSSoap12WSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("ServiceSMSSoap".equals(inputPortName)) {
            return getServiceSMSSoap();
        }
        else if ("ServiceSMSSoap12".equals(inputPortName)) {
            return getServiceSMSSoap12();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://webservice.youiwe.co.kr/", "ServiceSMS");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://webservice.youiwe.co.kr/", "ServiceSMSSoap"));
            ports.add(new javax.xml.namespace.QName("http://webservice.youiwe.co.kr/", "ServiceSMSSoap12"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException	{
        
		if ("ServiceSMSSoap".equals(portName)) {
		  setServiceSMSSoapEndpointAddress(address);
	    }
	    else if ("ServiceSMSSoap12".equals(portName)) {
		  setServiceSMSSoap12EndpointAddress(address);
        }
        else { // Unknown Port Name
		  throw new javax.xml.rpc.ServiceException("Cannot set Endpoint Address for Unknown Port" + portName);	  
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
