package br.com.marcosoft.dbdesigner.util;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;

import org.apache.commons.beanutils.PropertyUtils;

/**
 * Classe para manipulacao de beans.
 */
public final class BeanHelper {

    /**
     * Constutor privado.
     */
    private BeanHelper() {
    }

    /**
     * Le o valor de um campo no objeto informado.
     * @param objeto objeto informado
     * @param fieldName nome do campo
     * @return valor do campo no objeto informado.
     */
    public static Object readField(Object objeto, String fieldName) {
        try {
            return PropertyUtils.getProperty(objeto, fieldName);
        } catch (final IllegalAccessException e) {
            throw new IllegalStateException(e);
        } catch (final InvocationTargetException e) {
            throw new IllegalStateException(e);
        } catch (final NoSuchMethodException e) {
            throw new IllegalStateException(e);
        }
    }

    /**
     * Escreve o valor informado em um campo do objeto informado.
     * @param objeto objeto informado
     * @param fieldName nome do campo
     * @param value valor a ser escrito
     */
    public static void writeField(Object objeto, String fieldName, Object value) {
        try {
            PropertyUtils.setProperty(objeto, fieldName, value);
        } catch (final IllegalAccessException e) {
            throw new IllegalStateException(e);
        } catch (final InvocationTargetException e) {
            throw new IllegalStateException(e);
        } catch (final NoSuchMethodException e) {
            throw new IllegalStateException(e);
        }
    }

    /**
     * Escreve o valor informado em um campo do objeto informado. Forcando a escrita se o
     * campo nao é acessivel.
     * @param object objeto informado
     * @param fieldName nome do campo
     * @param value valor a ser escrito
     */
    public static void writeFieldForceAccessibility(Object object, String fieldName,
        Object value) {
        Field declaredField;
        try {
            declaredField = object.getClass().getDeclaredField(fieldName);
        } catch (final NoSuchFieldException e) {
            throw new IllegalStateException(e);
        }
        final boolean accessible = declaredField.isAccessible();
        if (!accessible) {
            declaredField.setAccessible(true);
        }
        try {
            declaredField.set(object, value);
        } catch (final IllegalAccessException e) {
            throw new IllegalStateException(e);
        } finally {
            declaredField.setAccessible(accessible);
        }
    }


    /**
     * Le o valor de um campo no objeto auditavel informado.
     * @param object objeto auditavel informado
     * @param field campo
     * @return valor do campo
     */
    public static Object readField(Object object, Field field) {
        final boolean accessible = field.isAccessible();
        if (!accessible) {
            field.setAccessible(true);
        }

        try {
            return field.get(object);
        } catch (final IllegalAccessException e) {
            throw new IllegalStateException(e);
        } finally {
            field.setAccessible(accessible);
        }
    }
}
